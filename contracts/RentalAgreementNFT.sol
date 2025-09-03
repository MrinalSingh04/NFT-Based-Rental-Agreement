// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RentalAgreementNFT is ERC721, Ownable {
    struct Lease {
        address landlord;
        address renter;
        uint256 rentAmount;
        uint256 securityDeposit;
        uint256 startDate;
        uint256 endDate;
        uint256 lastPaid;
        bool active;
    }

    uint256 public leaseCounter;
    mapping(uint256 => Lease) public leases;

    constructor() ERC721("RentalAgreementNFT", "RENT") Ownable(msg.sender) {}

    /// @notice Create a new rental lease and mint NFT to renter
    function createLease(
        address renter,
        uint256 rentAmount,
        uint256 securityDeposit,
        uint256 durationMonths
    ) external payable {
        require(renter != address(0), "Invalid renter");
        require(rentAmount > 0, "Rent must be > 0");
        require(durationMonths > 0, "Duration must be > 0");
        require(
            msg.value == securityDeposit + rentAmount,
            "Deposit + 1st month rent required"
        );

        leaseCounter++;
        uint256 leaseId = leaseCounter;

        leases[leaseId] = Lease({
            landlord: msg.sender,
            renter: renter,
            rentAmount: rentAmount,
            securityDeposit: securityDeposit,
            startDate: block.timestamp,
            endDate: block.timestamp + (30 days * durationMonths),
            lastPaid: block.timestamp,
            active: true
        });

        _mint(renter, leaseId);

        // Pay landlord first month rent immediately
        payable(msg.sender).transfer(rentAmount);
    }

    /// @notice Pay monthly rent
    function payRent(uint256 leaseId) external payable {
        Lease storage lease = leases[leaseId];
        require(lease.active, "Lease inactive");
        require(msg.sender == lease.renter, "Only renter can pay");
        require(msg.value == lease.rentAmount, "Incorrect rent");
        require(
            block.timestamp >= lease.lastPaid + 30 days,
            "Too early to pay"
        );

        lease.lastPaid = block.timestamp;
        payable(lease.landlord).transfer(msg.value);
    }

    /// @notice End lease and return deposit to renter
    function endLease(uint256 leaseId) external {
        Lease storage lease = leases[leaseId];
        require(lease.active, "Lease already ended");
        require(
            msg.sender == lease.landlord || msg.sender == lease.renter,
            "Not authorized"
        );
        require(block.timestamp >= lease.endDate, "Lease not ended");

        lease.active = false;
        _burn(leaseId);

        // Refund deposit to renter
        payable(lease.renter).transfer(lease.securityDeposit);
    }

    /// @notice View details of a lease
    function getLease(uint256 leaseId) external view returns (Lease memory) {
        return leases[leaseId];
    }
}

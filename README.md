# 🏠 NFT-Based Rental Agreement

## 📌 Overview

This project implements a **Rental Agreement Smart Contract** on Ethereum (or any EVM-compatible blockchain).  
It leverages **ERC-721 NFTs** as **digital proof of lease** between a landlord and a renter.

Each lease is represented by a unique NFT that is time-bound and linked to specific rental terms.  
Rent payments and security deposits are managed transparently on-chain, reducing disputes and middlemen.

---      
        
## ❓ What is this project?      
 
✨ A **smart contract** written in Solidity (`^0.8.25`).    
🔗 Uses **OpenZeppelin Contracts** for ERC-721 and ownership management.  
👨‍💼 **Landlord** creates a lease → 👩‍💻 **Renter** signs → 🎟️ NFT minted as proof.  
💰 Rent is paid monthly and **auto-transferred** to the landlord.  
🔒 **Security deposits** are locked in the contract and refunded at lease end.  
⏳ NFT **expires** once lease duration ends.

---

## 💡 Why build this?

Traditional rental agreements suffer from:  
❌ Lack of transparency (hidden fees, unclear terms)  
❌ Delays in rent payments  
❌ Disputes over deposit refunds  
❌ No verifiable proof of agreement

✅ With this smart contract:

- Both parties have a **tamper-proof digital lease certificate (NFT)**
- **Rent flows automatically** to the landlord on time
- **Deposits are escrowed** on-chain → no unfair withholding
- Agreements are **transparent & verifiable** by anyone

---

## ⚙️ Features

- 🎟️ **NFT Lease Certificate** – Each lease = ERC-721 NFT
- 💸 **Automatic Rent Payment** – Rent → landlord each month
- 🔒 **Security Deposit Escrow** – Locked until lease ends
- ⏳ **Time-Bound Leases** – NFTs expire after set duration
- 🧾 **Transparent History** – All actions are on-chain

---

## 📜 Example Flow

### 🏠 Landlord creates a lease

- **Inputs:** renter address, rent, deposit, duration
- **Pays:** deposit + first month rent
- **Output:** 🎟️ NFT minted → renter, 💰 rent sent → landlord

---

### 💳 Renter pays monthly rent

- **Action:** Calls `payRent()` with rent amount
- **Result:** 💸 Contract sends rent → landlord

---

### 🔚 Lease ends

- **Action:** `endLease()` can be called after duration
- **Effect:** 🔥 NFT burned
- **Refund:** 🔒 Deposit refunded → renter

--

## 📌 License

📜 Licensed under the MIT License.

# Library System Smart Contract

This is a Solidity smart contract for a simple library system that allows users to add books, borrow books, and return books. It also includes a special "warden" role that can withdraw funds from the contract.

## Features

- Add books to the library.
- Borrow books and specify the number of days to borrow.
- Return books to the library.
- "Warden" can withdraw ether from the contract.

## Usage

![Screenshot 2023-11-07 114047](https://github.com/Areeba000/diamondContract/assets/140241495/4b282d97-e9bd-46b7-ba64-565a5315dcce)


### Contract Deployment

1. Deploy the contract to the Ethereum blockchain.

### Initialization

1. Call the `initializelibrarydata` function to set the "warden" of the library.

### Adding Books

1. Call the `addBook` function with the book's title and author to add a new book to the library.

### Borrowing Books

1. Call the `borrowBook` function with the book ID and the number of days to borrow.
2. Send 1 ether as payment to borrow a book.
3. The book will be marked as unavailable, and the due date will be set.

### Returning Books

1. Call the `returnBook` function with the book ID to return a book to the library.

### Warden Withdrawal

1. Only the "warden" can call the `withdraw` function to withdraw ether from the contract.

### Get Book Details

1. Use the `getBookDetails` function to retrieve book details by providing the book ID.

## Modifiers

- `onlyAvailable`: Ensures that a book is available for borrowing.
- `onlywarden`: Restricts functions to the "warden" only.

## Smart Contract State

- The contract maintains a list of books with their details, including availability and due dates.
- It keeps track of the book count.
- The "warden" address is set during initialization.

## Smart Contract Balance

- The contract holds a balance in ether, which can be withdrawn by the "warden" using the `withdraw` function.



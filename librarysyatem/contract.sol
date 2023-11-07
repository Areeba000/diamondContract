// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LibrarySystem { bytes32 internal constant LIBRARYNAMESPACE = keccak256('library.facet');
    function libraryStorage() internal pure returns( librarydata storage s) {
        bytes32 position = LIBRARYNAMESPACE;
        assembly {
            s.slot := position
        }
      }
    struct librarydata{
    address  warden;
    mapping(uint256 => Book)  books;
    Book data;
    }
    struct Book {
        string title;
        string author;
        bool available;
        address borrower;
        uint256 dueDate;
    }
    uint256 public bookCount;
    function initializelibrarydata() public {
        librarydata storage s = libraryStorage();
        s.warden=msg.sender;
    }

    modifier onlyAvailable(uint256 bookId) {
        librarydata storage s = libraryStorage();
        require(s.books[bookId].available, "Book is not available");
        _;
    }

    modifier onlywarden{
        librarydata storage s = libraryStorage();
        require(s.warden==msg.sender,"you are not warden");
        _;
    }

    function addBook(string memory title, string memory author) public {
        librarydata storage s = libraryStorage();
        bookCount++;
        s.books[bookCount] = Book({
            title: title,
            author: author,
            available: true,
            borrower: address(0),
            dueDate: 0
        });
    }

    function borrowBook(uint256 bookId, uint256 daysToBorrow) public payable  onlyAvailable(bookId) {
        librarydata storage s = libraryStorage();
        require(msg.value == 1 ether,"not enough ether");
        s.books[bookId].available = false;
        s.books[bookId].borrower = msg.sender;
        s.books[bookId].dueDate = block.timestamp + (daysToBorrow * 1 days);

    }

    function returnBook(uint256 bookId) public  {
        librarydata storage s = libraryStorage();
        require(s.books[bookId].borrower == msg.sender, "You are not the borrower");
        s.books[bookId].available = true;
        s.books[bookId].borrower = address(0);
        s.books[bookId].dueDate = 0;
        
    } 

    function withdraw() public  onlywarden {
        librarydata storage s = libraryStorage();
        payable(s.warden).transfer(address(this).balance);
     
    }

    function getBookDetails(uint256 bookId) public view returns (string memory, string memory, bool, address, uint256) {
        librarydata storage s = libraryStorage();
        return (
        s.books[bookId].title, 
        s.books[bookId].author, 
        s.books[bookId].available, 
        s.books[bookId].borrower, 
        s.books[bookId].dueDate
        );
    }
}

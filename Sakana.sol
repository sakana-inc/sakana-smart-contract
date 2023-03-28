pragma solidity ^0.8.0;

contract Sakana {
    struct Idea {
        uint256 id;
        string contentHash;
        address owner;
    }

    mapping(address => Idea[]) public ideas;
    uint256 private ideaCounter;

    event IdeaRegistered(uint256 indexed id, string contentHash, address indexed owner);
    event IdeaModified(uint256 indexed id, string contentHash, address indexed owner);
    event IdeaDeleted(uint256 indexed id, address indexed owner);

    function registerIdea(string memory contentHash) public {
        ideaCounter++;
        Idea memory newIdea = Idea(ideaCounter, contentHash, msg.sender);
        ideas[msg.sender].push(newIdea);
        emit IdeaRegistered(ideaCounter, contentHash, msg.sender);
    }

    function retrieveIdea(uint256 id) public view returns (string memory) {
        Idea[] memory userIdeas = ideas[msg.sender];
        for (uint256 i = 0; i < userIdeas.length; i++) {
            if (userIdeas[i].id == id) {
                return userIdeas[i].contentHash;
            }
        }
        revert("Idea not found");
    }

    function modifyIdea(uint256 id, string memory newContentHash) public {
        Idea[] storage userIdeas = ideas[msg.sender];
        for (uint256 i = 0; i < userIdeas.length; i++) {
            if (userIdeas[i].id == id) {
                userIdeas[i].contentHash = newContentHash;
                emit IdeaModified(id, newContentHash, msg.sender);
                return;
            }
        }
        revert("Idea not found");
    }

    function deleteIdea(uint256 id) public {
        Idea[] storage userIdeas = ideas[msg.sender];
        for (uint256 i = 0; i < userIdeas.length; i++) {
            if (userIdeas[i].id == id) {
                userIdeas[i] = userIdeas[userIdeas.length - 1];
                userIdeas.pop();
                emit IdeaDeleted(id, msg.sender);
                return;
            }
        }
        revert("Idea not found");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sakana {
    struct Idea {
        uint256 id;
        string contentHash;
    }

    mapping(address => mapping(uint256 => Idea)) public ideas;
    mapping(address => uint256) public ideaCount;

    event IdeaRegistered(uint256 indexed id, string contentHash, address indexed owner);
    event IdeaModified(uint256 indexed id, string contentHash, address indexed owner);
    event IdeaDeleted(uint256 indexed id, address indexed owner);

    function registerIdea(string memory contentHash) public {
        uint256 newId = ideaCount[msg.sender] + 1;
        ideas[msg.sender][newId] = Idea(newId, contentHash);
        ideaCount[msg.sender] = newId;

        emit IdeaRegistered(newId, contentHash, msg.sender);
    }

    function retrieveIdea(uint256 id) public view returns (string memory) {
        Idea storage idea = ideas[msg.sender][id];
        require(idea.id != 0, "Idea not found");

        return idea.contentHash;
    }

    function modifyIdea(uint256 id, string memory newContentHash) public {
        Idea storage idea = ideas[msg.sender][id];
        require(idea.id != 0, "Idea not found");

        idea.contentHash
        = newContentHash;

        emit IdeaModified(id, newContentHash, msg.sender);
    }

    function deleteIdea(uint256 id) public {
        Idea storage idea = ideas[msg.sender][id];
        require(idea.id != 0, "Idea not found");

        delete ideas[msg.sender][id];

        emit IdeaDeleted(id, msg.sender);
    }
}

pragma solidity ^0.5.16;

contract SocialNetwork {
	string public name; 
	uint public postCount = 0;
	mapping(uint => Post) public posts;

	struct Post {
		uint id; 
		string content;
		uint tipAmount;
		address payable author;
	}

	event PostCreated(
		uint id,
		string content,
		uint tipAmount,
		address payable author
	);

	event PostTipped(
		uint id,
		string content,
		uint tipAmount,
		address payable author
	);

	constructor() public {
		name = "Dapp University Social Network";
	}

	function createPost(string memory _content) public {
		require(bytes(_content).length > 0);
		postCount++;
		posts[postCount] = Post(postCount, _content, 0, msg.sender);
		emit PostCreated(postCount, _content, 0, msg.sender);
	}

	function tipPost(uint _id) public payable {
		require(_id > 0 && _id <= postCount);

		Post memory _post = posts[_id];
		address payable _author = _post.author;
		_author.transfer(msg.value);
		_post.tipAmount = _post.tipAmount + msg.value;
		posts[_id] = _post; 
		emit PostTipped(_id, _post.content, _post.tipAmount, _author);

	}

	
}
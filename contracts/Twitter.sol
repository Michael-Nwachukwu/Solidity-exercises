// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Twitter {

    // set max character limit for tweet
    uint256 public maxTweetCharacter = 5;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, 'You are not the owner');
        _;
    }

    /** 
     * @notice Structure for a Tweet.
     * @dev Contains the content of the tweet, owner's address, timestamp and likes count.
    */
    struct Tweet {
        // id of the tweet
        uint256 id;
        // actual tweet content
        string content;
        // store the address of the owner of the tweet
        address owner;
        // store the time when tweet was created
        uint256 time;
        // likes
        uint256 like;
    }
    
    // save tweets in an array value with an owner address key
    mapping (address => Tweet[]) public tweets;

    /** 
     * @dev This function allows a user to create a new tweet.
     * @param _content The content/message of the tweet.
     * @custom:requirement The length of `_content` should not exceed `maxCharacter`.
    */
    function createTweet(string memory _content) public onlyOwner {
                
        // create an instance of the struct
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            content: _content,
            owner: msg.sender,
            time: block.timestamp,
            like: 0
        });

        // convert the content string into bytes to be able to calcultae character length
        require(bytes(_content).length <= maxTweetCharacter, "max xter is 5");

        tweets[msg.sender].push(newTweet);
    }
    
    function changeTweetLength(uint _newTweetLength) public onlyOwner {
        // update the value of the variable maxTweetCharacters
        maxTweetCharacter = _newTweetLength;
    }

    // uint public amount = 0.001 ether;
    
    // function payForBlue(address payable _to) public payable onlyOwner {
    //     require(address(this).balance >= amount, "Insufficient balance");
    //     require(msg.value == amount, "Invalid amount");
    //     (bool sent, ) = _to.call{value: amount}("");
    //     require(sent, "Failed");
    //     changeTweetLength(100);
    // }

    /** 
     * @dev This function allows a user to like another tweet.
     * @param _id The index of the tweet to be liked in the owner's list of tweets.
    */
    function like(uint256 _id) external {
        // verify that the tweet exist by checking that the id  
        require(tweets[owner][_id].id == _id, "Tweet does not exist");
        // get the owner address and index of the tweet to be liked from the user input
        tweets[msg.sender][_id].like++;
    }

    function unLike(uint256 _id) external {
        // verify that the tweet exist by checking that the id  
        require(tweets[owner][_id].id == _id, "Tweet does not exist");
        // makle sure that tweet count is not zero (ie) make sure that the tweet actually has likes to unlike
        require(tweets[msg.sender][_id].like >= 0, "Tweet has no likes");

        // get the owner address and index of the tweet to be liked from the user input
        tweets[msg.sender][_id].like--;
    }
    
    /** 
     * @dev This function allows a user to get their specific tweet.
     * @param _i The index of the tweet in `_owner`'s list of tweets.
     * @return The requested Tweet.
    */
    function getTweets(uint _i) view public returns (Tweet memory){
        return tweets[msg.sender][_i];
    }

    /** 
     * @dev This function allows a user to get all their tweets.
     * @return An array of Tweet containing all tweets from `_owner`.
    */
    function getAllTweets() view public returns (Tweet[] memory){
        return tweets[msg.sender];
    }
}
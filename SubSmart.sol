// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title SubSmart Protocol MVP
 * @dev Decentralized Recurring Billing on Polygon
 */
contract SubSmart {
    
    address public protocolOwner;
    uint256 public protocolFee = 50; // 0.5% fee (basis points)
    
    struct Plan {
        address merchant;
        uint256 amount;
        uint256 cycle; // duration in seconds (e.g., 30 days = 2592000)
        bool active;
    }
    
    struct Subscription {
        address subscriber;
        uint256 nextPaymentDue;
        bool active;
    }
    
    mapping(uint256 => Plan) public plans;
    mapping(uint256 => mapping(address => Subscription)) public subscriptions;
    uint256 public planCounter;
    
    event PlanCreated(uint256 indexed planId, address indexed merchant, uint256 amount, uint256 cycle);
    event Subscribed(uint256 indexed planId, address indexed subscriber, uint256 nextPaymentDue);
    event PaymentProcessed(uint256 indexed planId, address indexed subscriber, uint256 amount, uint256 fee);

    constructor() {
        protocolOwner = msg.sender;
    }

    // MVP Feature: Create a new subscription plan
    function createPlan(uint256 _amount, uint256 _cycle) external returns (uint256) {
        require(_amount > 0, "Amount must be greater than zero");
        require(_cycle > 0, "Cycle must be greater than zero");
        
        planCounter++;
        plans[planCounter] = Plan({
            merchant: msg.sender,
            amount: _amount,
            cycle: _cycle,
            active: true
        });
        
        emit PlanCreated(planCounter, msg.sender, _amount, _cycle);
        return planCounter;
    }

    // MVP Feature: User subscribes to a plan (Simulated approval)
    function subscribe(uint256 _planId) external {
        Plan memory plan = plans[_planId];
        require(plan.active, "Plan does not exist or is inactive");
        require(!subscriptions[_planId][msg.sender].active, "Already subscribed");
        
        // In a real dApp, we would check ERC20 allowances here
        
        subscriptions[_planId][msg.sender] = Subscription({
            subscriber: msg.sender,
            nextPaymentDue: block.timestamp + plan.cycle,
            active: true
        });
        
        emit Subscribed(_planId, msg.sender, block.timestamp + plan.cycle);
    }

    // MVP Feature: Process recurring payment (Dummy logic for UI testing)
    function processPayment(uint256 _planId, address _subscriber) external {
        Plan memory plan = plans[_planId];
        Subscription storage sub = subscriptions[_planId][_subscriber];
        
        require(plan.active, "Plan inactive");
        require(sub.active, "Subscription inactive");
        require(block.timestamp >= sub.nextPaymentDue, "Payment not due yet");
        
        // Calculate fee
        uint256 feeAmount = (plan.amount * protocolFee) / 10000;
        uint256 merchantAmount = plan.amount - feeAmount;
        
        // In real dApp: transferFrom(subscriber, merchant, merchantAmount)
        // In real dApp: transferFrom(subscriber, protocolOwner, feeAmount)
        
        // Update next payment date
        sub.nextPaymentDue = block.timestamp + plan.cycle;
        
        emit PaymentProcessed(_planId, _subscriber, plan.amount, feeAmount);
    }
}
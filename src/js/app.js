App = {

  web3Provider: null,

  account: '0x0',
  contracts: {},
  init: async function() {



    return await App.initWeb3();
  },
  initWeb3: async function() {
      if (window.ethereum) {
            App.web3Provider = window.ethereum;
              try {

                  // Request account access
              await window.ethereum.enable();
              } catch (error) {
                              // User denied account access...
                               console.error("User denied account access");
                              }
              }
      // Legacy dapp browsers...
        else if (window.web3) {
                               App.web3Provider = window.web3.currentProvider;
                              }
         //     If no injected web3 instance is detected, fall back to Ganache
        else {
              App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
             }
        web3 = new Web3(App.web3Provider);

        return App.initContract();
    },
    initContract: function() {

    $.getJSON("CrowdMember.json", function(member) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.CrowdMember = TruffleContract(member);
      // Connect provider to interact with contract
      App.contracts.CrowdMember.setProvider(App.web3Provider);

      App.listenForEvents();

      return App.render();
    });
  },
    // Listen for events emitted from the contract
  listenForEvents: function() {
    App.contracts.CrowdMember.deployed().then(function(instance) {
      // Restart Chrome if you are unable to receive this event
      // This is a known issue with Metamask
      // https://github.com/MetaMask/metamask-extension/issues/2393
      instance.LogEnrolled({}, {

        fromBlock: 0,
        toBlock: 'latest'
      }).watch(function(error, event) {
        console.log("event triggered", event)
        window.alert("event triggered");
        // Reload when a new vote is recorded
        App.render();
      });
    });
  },
  render: function() {
      var memberInstance;
      var loader = $("#loader");
      var content = $("#content");

      //loader.show();
    //  content.hide();

      // Load account data
      web3.eth.getCoinbase(function(err, account) {

        if (err === null) {
          App.account = account;
          $("#accountAddress").html("Your Account: " + account);

          loader.hide();
          content.show();


        };
      });
      window.alert("Added new");
      App.contracts.CrowdMember.deployed().then(function(instance) {
      memberInstance = instance;
      window.alert(memberInstance.enrolled());
    //  $("#default").html(<h1 class="text-center" id="default">"Your Account: " + account+memberInstance.enrolled</h1>);
  });

  }
    //  App.contracts.CrowdMember.deployed().then(function(instance) {
    //  memberInstance = instance;
    //  $("#default").html(<h1 class="text-center" id="default">"Your Account: " + account+memberInstance.enrolled<h1>);
    //  }
};

$(function() {


      $(window).load(function() {
        App.init();
      });
    });

const CrowdMember = artifacts.require("./CrowdMember.sol");

module.exports = function(deployer) {
  deployer.deploy(CrowdMember);
};

const CrowdProject = artifacts.require("./Project.sol");

module.exports = function(deployer) {
  deployer.deploy(CrowdProject);
};

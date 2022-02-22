const HelloWorld = artifacts.require("HelloWorld");
const LoginSystem = artifacts.require("LoginSystem");
const EventContract = artifacts.require("EventContract");

module.exports = function (deployer) {
  // deployer.deploy(HelloWorld);
  deployer.deploy(LoginSystem);
  deployer.deploy(EventContract);
};

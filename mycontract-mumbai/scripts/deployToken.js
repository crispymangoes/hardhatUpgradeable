// scripts/deployToken.js
async function main() {
    const Token = await ethers.getContractFactory("GravityToken");
    console.log("Deploying Gravity Token...");
    const token = await upgrades.deployProxy(Token, ['Gravity Finance', 'GFI', '1000000000000000000000000'], { initializer: 'initialize' });
    console.log("Gravity Token deployed to:", token.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
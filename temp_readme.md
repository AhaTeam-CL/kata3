![logo](https://owo.whats-th.is/8mT5kxc.png)
##### Project rewrite coming soon™
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![version](https://img.shields.io/badge/stable_version-3.18.2-blue)

MCLC (Minecraft Launcher Core) is a NodeJS solution for launching modded and vanilla Minecraft without having to download and format everything yourself.
Basically a core for your Electron or script based launchers.

### Getting support
I've created a Discord server for anyone who needs to get in contact with me or get help!
<p>
   <a href="https://discord.gg/8uYVbXP">
   <img src="https://img.shields.io/discord/568550848871923723?logo=discord"
      alt="chat on Discord"></a>
<p>

### Installing

`npm i minecraft-launcher-core`

### Standard Example
```javascript
const { Client, Authenticator } = require('minecraft-launcher-core');
const launcher = new Client();

let opts = {
    // For production launchers, I recommend not passing 
    // the getAuth function through the authorization field and instead
    // handling authentication outside before you initialize
    // MCLC so you can handle auth based errors and validation!
    authorization: Authenticator.getAuth("username", "password"),
    root: "./minecraft",
    version: {
        number: "1.14",
        type: "release"
    },
    memory: {
        max: "6G",
        min: "4G"
    }
}

launcher.launch(opts);

launcher.on('debug', (e) => console.log(e));
launcher.on('data', (e) => console.log(e));
```
### Documentation

#### Client Functions

| Function | Type    | Description                                                                             |
|----------|---------|-----------------------------------------------------------------------------------------|
| `launch` | Promise | Launches the client with the specified `options`  as a parameter. Returns child the process |

##### launch

| Parameter                | Type     | Description                                                                               | Required |
|--------------------------|----------|-------------------------------------------------------------------------------------------|----------|
| `options.clientPackage`  | String   | Path or URL to a zip file, which will be extracted to the root directory. (Not recommended for production use)| False    |
| `options.removePackage`  | Boolean  | Option to remove the client package zip file after its finished extracting.               | False    |
| `options.root`           | String   | Path where you want the launcher to work in. `C:/Users/user/AppData/Roaming/.mc`          | True     |
| `options.cache`          | String   | Path where launcher files will be cached in. `C:/Users/user/AppData/Roaming/.mc/cache`    | False    |
| `options.os`             | String   | windows, osx or linux. MCLC will auto determine the OS if this field isn't provided.      | False    |
| `options.customLaunchArgs`| Array   | Array of custom Minecraft arguments you want to add.                                      | False    |
| `options.customArgs`     | Array    | Array of custom Java arguments you want to add.                                           | False    |
| `options.features`       | Array    | Array of game argument feature flags. ex: `is_demo_user` or `has_custom_resolution`       | False    |
| `options.version.number` | String   | Minecraft version that is going to be launched.                                           | True     |
| `options.version.type`   | String   | Any string. The actual Minecraft launcher uses `release` and `snapshot`.                  | True     |
| `options.version.custom` | String   | The name of the folder, jar file, and version json in the version folder.                 | False    |
| `options.memory.max`     | String   | Max amount of memory being used by Minecraft.                                             | True     |
| `options.memory.min`     | String   | Min amount of memory being used by Minecraft.                                             | True
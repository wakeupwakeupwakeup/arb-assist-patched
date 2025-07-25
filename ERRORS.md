# Common Errors you will run into

### 1. If your bot does not run and you see this in the config, it means there are no mints that met your filters and arb-assist has turned the bot off.

![image](https://github.com/user-attachments/assets/114a929f-9d3c-4dbd-a872-11a0d82213ff)

### 2. If SMB-Onchain gives you a "Failed to create token account: Error" you have run out of Native SOL in your wallet to create new token ATAs. You should fund your wallet with more Native SOL.

![image](https://github.com/user-attachments/assets/23a202ae-0c94-47c9-a31e-901df1afa1ba)

### 3. When you run ./arb-assist you get a <!DOCTYPE html> error, this means you tried to download the github repo using wget. You must either use git clone to grab the github repo or use wget on the direct link to the arb-assist file. Instructions are in the README.

![image](https://github.com/user-attachments/assets/cafdc9dd-f354-4ebf-b18f-4f1b8cd93043)

### 4. If you get an error for "Too many open files" you need to run this command before running arb-assist or smb-onchain:

```bash
ulimit -n 65536
```

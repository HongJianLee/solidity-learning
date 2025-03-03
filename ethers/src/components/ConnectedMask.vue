<template>
  <p>Connect MetaMask</p>
  <button @click="connect" class="connect-button">Connect</button>
  <div v-if="connected">
    <p class="status connected">Connected</p>
    <p class="account">{{ account }}</p>
  </div>
  <div v-else>
    <p class="status not-connected">Not Connected</p>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { ethers } from 'ethers';

const account = ref('');
const connected = ref(false);

const connect = async () => {
  if (window.ethereum) {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      account.value = signer.address;
      connected.value = true;
    } catch (e) {
      console.error(e);
      connected.value = false;
    }
  } else {
    console.error('MetaMask not installed!');
    connected.value = false;
  }
}
</script>

<style scoped>
.connect-button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
}

.connect-button:hover {
  background-color: #0056b3;
}

.status {
  margin-top: 10px;
  font-weight: bold;
}

.connected {
  color: green;
}

.not-connected {
  color: red;
}

.account {
  margin-top: 5px;
  font-family: monospace;
}
</style>

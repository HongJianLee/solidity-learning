<template>
  <ConnectedMask/>
</template>

<script>
import ConnectedMask from "@/components/ConnectedMask.vue";

export default {
  name: 'App',
  components: {
    ConnectedMask
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

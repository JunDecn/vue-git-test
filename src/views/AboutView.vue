<template>
  <div class="about">
    <h1>This is an about page</h1>
    <RouterLink to="/">Go to Home 777</RouterLink>
    <TheWelcome />
  </div>
</template>
<script setup>
import { RouterLink } from 'vue-router'
import TheWelcome from '@/components/TheWelcome.vue'
</script>

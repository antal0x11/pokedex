<script setup>
  import { ref } from 'vue'
  const data = ref("")
  const name = ref("")
  const error = ref(false)
  const imgURL = ref("")
  const hasImage = ref(false)

  async function fetchPokemon(){
    error.value = false
    const url = "https://pokeapi.co/api/v2/pokemon/" + name.value
    try {
      const response = await fetch(url);
      if (!response.ok) {
        error.value = true
        throw new Error(`Response status: ${response.status}`);
      }

      const json = await response.json();
      data.value = json
      imgURL.value = data.value.sprites.other.dream_world.front_default
      hasImage.value = imgURL.value.length != 0 ? true : false
    } catch (error) {
      error.value = true
      console.error(error.message);
    }
  }

</script>

<template>
  <main>
    <div class="row">
      <label for="inc">Searching pokemon: </label>
      <input v-model="name"></input>
      <button id="pokemon-btn" @click="fetchPokemon">Get Pokemon</button>
    </div>

    <div class="row-data">
      <div v-if="hasImage" class="img-block">
        <img :src="imgURL"/>
      </div>

      <div class="col">
        <pre id="results">{{ data }}</pre>
      </div>
    </div>

    <span v-if="error">An Error occured, is the name '{{ name.value }}' correct?</span>
  </main>
</template>

<style scoped>
  #pokemon-btn {
    width: fit-content;
    height: fit-content;
    padding: 5px;
    border: 1px solid black;
    border-radius: 5px;
    background-color: white;
  }

  #pokemon-btn:hover {
    cursor: pointer;
  }

  .col {
    display: flex;
    flex-direction: column;
  }

  .row {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    align-content: center;
    align-items: center;
    gap: 10px;
  }

  .img-block {
    height: fit-content;
    width: fit-content;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid black
  }

  .row-data {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    align-content: center;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
    margin-top: 20px;
  }
</style>

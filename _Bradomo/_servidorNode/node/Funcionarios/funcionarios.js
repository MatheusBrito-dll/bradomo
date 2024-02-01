const axios = require("axios");

const url = 'http://files.cod3r.com.br/curso-js/funcionarios.json';

axios.get(url, { timeout: 15000 }) // Defina um tempo limite em milissegundos (5 segundos no exemplo)
  .then(response => {
    const funcionarios = response.data;
    console.log(funcionarios);
  })
  .catch(error => {
    console.error(error);
  });



<script>

import dataServices from '@/services/dataServices'


export default{
  name: 'VistaPrueba',
  data(){
    return{
      pedidos: [],
      contratos: {},
      productos: [],
      pedidoConsultado: [],
      idContrato: '',
      idPedido: '',
      idProducto: [],
      contratoConsultado: [],
      productoConsultado: [],

    }
  },
  methods: {
    async getOrders () {
      var response = await dataServices.getOrders()
      this.pedidos = response.data
      console.log(this.pedidos)
    },
    async getContracts () {
      var response = await dataServices.getContracts()
      this.contratos = response.data
      this.idContrato = this.contratos.id
      console.log(this.contratos)
    },
    async getProductsDetails () {
      var response = await dataServices.getProductsDetails()
      this.productos = response.data
      console.log(this.productos)
    },

    async consultarIdContrato() {

      var response = await dataServices.getContractId(this.idContrato)
      this.contratoConsultado = response.data

      var idResponse = await dataServices.getOrderByContractId(this.idContrato)
      this.pedidoConsultado = idResponse.data

        if (this.pedidoConsultado.length > 0) {

            this.idProducto = []
            this.pedidoConsultado.forEach(item => {
              if (item.itemId) {

                this.idProducto.push(item.itemId)
                this.getDetails()
              }
            });

            //this.getDetails()

        } else {
          this.idProducto = null;
        }
      
      console.log(this.idContrato)
      console.log(this.contratoConsultado)
      console.log(this.pedidoConsultado)
      console.log(this.idProducto)
      console.log(this.productoConsultado)
    },

    async getDetails() {

      if(this.idProducto.length === 1){

        var response = await dataServices.getProductId(this.idProducto);
        this.productoConsultado = response.data

      }
      
    }

  },
  created () {
    //this.getOrders(),
    //this.getContracts(),
    //this.getProductsDetails()
    
  }
}


</script>

<template>

<div class="grid">
  <form @submit.prevent="consultarIdContrato">
  <div class="inputs-grid">
    <input v-model="idContrato" class="form-control w-25" type="text" placeholder="Ingrese id de contrato..." required>
    <button type="submit" class="btn btn-outline-primary rounded-pill btn-lg bi bi-search"> Buscar </button>
  </div>
</form>
  <div class="data-grid">
    <div>Código de curso: {{ contratoConsultado.courseCode }}</div>
    <div>Fecha de alta: {{ contratoConsultado.fechaAlta }}</div>
    <div>Colegio: {{ contratoConsultado.colegioNombre }}</div>
    <div>Nivel: {{ contratoConsultado.colegioNivel }}</div>
    <div>Curso: {{ contratoConsultado.colegioCurso }}</div>
    <div>Localidad: {{ contratoConsultado.colegioLocalidad }}</div>
    <div class="order-grid">
      --PEDIDOS--
      <div>Cantidad: {{ contratoConsultado.cantidadEgresados }} </div>
      <div>Artículo: {{ productoConsultado.nombre }} </div>
      <div>Precio unitario: {{ productoConsultado.precio }} </div>
      <div>Total: $ {{ (parseFloat(productoConsultado.precio) * parseFloat(contratoConsultado.cantidadEgresados)).toFixed(2) }}</div>
    </div>
    <div> Importe total: ${{ contratoConsultado.total }}</div>
    <div>Fecha de entrega: {{ contratoConsultado.fechaEntrega }} </div>
  </div>
</div>
  
</template>

<style>

  .data-grid{
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 1em;
  }

  .data-grid div{
    border: 1px solid black;
    border-radius: 15px;
  }

  .order-grid{
    display: grid;
    grid-row: 2/4;
    height: auto;
    gap: 1em;
  }

  .inputs-grid{
    display: flex;
    justify-content: center;
    gap: 1em;
  }

  .grid div{
    padding: 1em;
    
    
  }

  .grid div:hover{
    border: 1px solid yellow;
  }
</style>
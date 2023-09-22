<script>

import dataServices from '@/services/dataServices'


export default{
  name: 'VistaPrueba',
  data(){
    return{
      pedidos: [],
      contratos: [],
      productos: [],
      idContrato: '',
      idPedido: '',
      idProducto: '',
      pedidoConsultado: [],
      contratoConsultado: [],
      productoConsultado: [],

    }
  },
  methods: {
    async getOrders () {
      var response = await dataServices.getOrders()
      this.colegios = response.data
      console.log(this.colegios)
    },
    async getContracts () {
      var response = await dataServices.getContracts()
      this.contratos = response.data
      console.log(this.contratos)
    },
    async getProductsDetails () {
      var response = await dataServices.getProductsDetails()
      this.productos = response.data
      console.log(this.productos)
    },

    async consultarIdContrato() {
      var response = await dataServices.getContractId(this.idContrato.valueOf);
      this.contratoConsultado = response.data;
    },
    // async consultarIdColegio() {
    //   var response = await dataServices.getColegioId(this.idColegio);
    //   this.idColegio = response.data;
    //   var dataField = this.getColegioId(this.idContrato);
    //   this.colegioConsultado = dataField.data
    // },
    // async consultarIdProducto(){
    //   var response = await dataServices.getProductoId(this.idProducto);
    //   this.productoConsultado = response.data;
    // }


  },
  created () {
    this.getOrders(),
    this.getContracts(),
    this.getProductsDetails()
    
  }
}

// function listarPorId(id){
//   id = getColegios(this.idColegio)
// }

</script>

<template>
<div class="d-flex justify-content-center mt-2">
    <input v-model="idContrato" class="form-control w-25" type="text" placeholder="Ingrese id de contrato...">
    <button @click="consultarIdContrato" class="btn btn-primary">Consultar</button>
</div>
<br>
<div class="d-flex justify-content-center" style="background-color: gray;">
  <ul v-for="contrato in contratoConsultado" :key="contrato" class="w-50">
    <li>Código de curso: {{ contrato.courseCode }}</li>
    <li>Fecha de alta: {{ contrato.fechaAlta }}</li>
    <li>Colegio: {{ contrato.colegioNombre }}</li>
    <li>Nivel: {{ contrato.colegioNivel }}</li>
    <li>Curso: {{ contrato.colegioCurso }}</li>
    <li>Localidad: {{ contrato.colegioLocalidad }}</li>
    <li>---Pedido--- </li>
    <li>Cantidad: {{ contrato.cantidadEgresados }}</li>
  </ul>
  <!-- <ul v-for="producto in productoConsultado" :key="producto">
    <li>Artículo: {{ producto.nombre }}</li>
    <li>Precio Unitario: {{ producto.precio }}</li>
  </ul> -->
</div>
<!-- <div class="d-flex justify-content-center" style="background-color: aquamarine">
  <ul v-for="contrato in contratoConsultado" :key="contrato" class="w-50">
   
  </ul>
</div> -->

  
</template>
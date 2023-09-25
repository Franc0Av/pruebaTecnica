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
      showData: false,
      suma: '',

    }
  },
  methods: {
    async getOrders () {
      var response = await dataServices.getOrders();
      this.pedidos = response.data;
      console.log(this.pedidos);
    },
    async getContracts () {
      var response = await dataServices.getContracts();
      this.contratos = response.data;
      this.idContrato = this.contratos.id;
      console.log(this.contratos);
    },
    async getProductsDetails () {
      var response = await dataServices.getProductsDetails();
      this.productos = response.data;
      console.log(this.productos);
    },

    async consultarIdContrato() {

      //LLAMADA A CONTRATOS POR ID
      try {
        var response = await dataServices.getContractId(this.idContrato);
        this.contratoConsultado = response.data;
      } catch (error) {
        alert("Contrato inexistente");
        this.showData = false;
      }

      //llAMADA A PEDIDOS POR CONTRACTID
        var idResponse = await dataServices.getOrderByContractId(this.idContrato);
        this.pedidoConsultado = idResponse.data;

      //ALMACENADO DE ITEMID EN EL ARRAY, OBTENIDO DEL/LOS PEDIDO/S SOLICITADO/S
      if(this.pedidoConsultado.length > 0){

            this.idProducto = [];
              this.pedidoConsultado.forEach(item => {
                if (item.itemId) {

                  this.idProducto.push(item.itemId);
                  
                }
              });
            
            this.showData = true;

      } 
      else
      {
          alert("No existen pedidos en el contrato solicitado");
          this.showData = false;
      }

      //LLAMADAS MULTIPLES EN CASO DE CONTRATO CON MAS DE UN PEDIDO
      if (this.idProducto.length > 0) {

          const resultados = [];

            for (const id of this.idProducto) {
              try {

                const response = await dataServices.getProductId(id);
                resultados.push(response.data);

              } catch (error) {

                console.error(`Error al obtener detalles del producto ${id}: ${error}`);
              }
            }

          this.productoConsultado = resultados;

      }

        this.getTotal();
    },

    async getTotal() {
      
      if(this.productoConsultado.length > 0){
        
        let sum = 0;

        for(const x of this.productoConsultado){
          const total = x.precio;
          sum += total;
        }

        this.suma = sum;
      }

    },

  },
  created () {
    
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
  <div v-if="showData" class="data-grid">
    <div class="text-bg-dark">Código de curso: {{ contratoConsultado.courseCode }}</div>
    <div class="text-bg-dark">Fecha de alta: {{ contratoConsultado.fechaAlta }}</div>
    <div class="text-bg-dark">Colegio: {{ contratoConsultado.colegioNombre }}</div>
    <div class="text-bg-dark">Nivel: {{ contratoConsultado.colegioNivel }}</div>
    <div class="text-bg-dark">Curso: {{ contratoConsultado.colegioCurso }}</div>
    <div class="text-bg-dark">Localidad: {{ contratoConsultado.colegioLocalidad }}</div>
    <div class="order-grid text-bg-primary">
      <div class="d-flex justify-content-center">PEDIDOS</div>
      <div class="text-bg-dark">Cantidad: {{ contratoConsultado.cantidadEgresados }} </div>
      <div id="prod-data" v-for="producto in productoConsultado" :key="producto" class="text-bg-dark">
        <div class="text-bg-primary">
          Artículo: {{ producto.nombre }}
        </div>
        <div class="text-bg-primary">
          Precio Unitario: $ {{ producto.precio }}
        </div>
        <div class="text-bg-primary">
          Total: $ {{ (parseFloat(producto.precio) * parseFloat(contratoConsultado.cantidadEgresados)).toFixed(2) }}
        </div>
      </div>
    </div>
    <div id="imp-total" class="text-bg-success"> Importe total: $ {{ parseFloat((contratoConsultado.cantidadEgresados * suma)).toFixed() }} </div>
    <div class="text-bg-warning">Fecha de entrega: {{ contratoConsultado.fechaEntrega }} </div>
  </div>
</div>
  
</template>

<style>

  .data-grid{
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 1em;
    text-align: center;
  }

  #prod-data{
    display: grid;
    gap: 1em;
  }

  #imp-total{
    display: grid;
    align-items: center;
  }

  .data-grid div{
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

</style>
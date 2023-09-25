import api from "./api"

export default {

   getOrders(){

    return api().get('/api/Pedidos');

   },

   getContracts(){

    return api().get('/api/Contratos');
    
   },

   getProductsDetails(){

      return api().get('/api/DetalleProductos');

   },

   getOrderId(id){
      return api().get(`/api/Pedidos/${id}`);
   },

   getOrderByContractId(id){
      return api().get(`/api/Pedidos/porContrato/${id}`);
   },

   getContractId(id) {
      return api().get(`/api/Contratos/${id}`);
    },

    getProductId(id) {
      return api().get(`/api/DetalleProductos/${id}`);
    }
        
    
}
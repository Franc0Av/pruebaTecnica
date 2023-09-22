import api from "./api"

export default {

   getOrders(){

    return api().get('/api/Pedidos')

   },

   getContracts(){

    return api().get('/api/Contratos')
    
   },

   getProductsDetails(){

      return api().get('/api/DetalleProductos')

   },

   getOrderId(id){
      return api().get(`/api/Pedidos/${id}`)
   },

   getContractId(string) {
      return api().get(`/api/Contratos/${string}`);
    },

    getProductoId(string) {
      return api().get(`/api/DetalleProductos/${string}`);
    }
        
    
}
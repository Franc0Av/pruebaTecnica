import axios from "axios";

export default() => {
    return axios.create({
        baseURL: 'https://localhost:7207/',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    })
}
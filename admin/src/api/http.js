import axios from "axios";

const http = axios.create({
  baseURL: "http://192.168.1.43:3000/api/admin", // Backend address
  timeout: 4000,
  // prettier-ignore
  headers: { "authorization": "Bearer " + localStorage.getItem("token") } //JWT token header
});

http.interceptors.response.use(undefined, err => {
  /* Handle timeout and retry */
  if (err.code === "ECONNABORTED") {
    if (!err.config.retry) return Promise.reject(err);
    err.config.__retryCount = err.config.__retryCount || 0;
    if (err.config.__retryCount >= err.config.retry) return Promise.reject(err);
    err.config.__retryCount += 1;
    return new Promise(resolve => {
      setTimeout(() => {
        resolve();
      }, err.config.retryDelay || 1);
    }).then(() => {
      return http(err.config);
    });
  }

  return Promise.reject(err);
});

export default http;

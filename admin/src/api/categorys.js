import http from "@/api/http.js";

const getCategorys = async () => {
  try {
    const res = await http.get("/getcategorys", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const addCategory = async payload => {
  try {
    const res = await http.post("/addcategory", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const editCategory = async payload => {
  try {
    const res = await http.post("/editcategory", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const deleteCategory = async payload => {
  try {
    const res = await http.post("/deletecategory", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getCategorys, addCategory, editCategory, deleteCategory };

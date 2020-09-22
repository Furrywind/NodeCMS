import http from "@/api/http.js";

const getArticles = async () => {
  try {
    const res = await http.get("/getarticles", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const getArticle = async query => {
  try {
    const res = await http.get(
      "/getarticle",
      { params: { cid: query } },
      { retry: 3, retryDelay: 100 }
    );
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const addArticle = async payload => {
  try {
    const res = await http.post("/addarticle", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const editArticle = async payload => {
  try {
    const res = await http.post("/editarticle", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const deleteArticle = async payload => {
  try {
    const res = await http.post("/deletearticle", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getArticles, getArticle, addArticle, editArticle, deleteArticle };

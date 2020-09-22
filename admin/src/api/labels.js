import http from "@/api/http.js";

const getLabels = async () => {
  try {
    const res = await http.get("/getlabels", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const addLabel = async payload => {
  try {
    const res = await http.post("/addlabel", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const editLabel = async payload => {
  try {
    const res = await http.post("/editlabel", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const deleteLabel = async payload => {
  try {
    const res = await http.post("/deletelabel", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getLabels, addLabel, editLabel, deleteLabel };

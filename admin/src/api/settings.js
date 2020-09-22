/* NOT COMPLETE */

import http from "@/api/http.js";

const getDashboard = async () => {
  try {
    const res = await http.get("/getdashboard", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const getSettings = async () => {
  try {
    const res = await http.get("/getsettings", {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const editSettings = async payload => {
  try {
    const res = await http.post("/editsettings", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getDashboard, getSettings, editSettings };

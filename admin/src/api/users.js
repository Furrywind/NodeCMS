import http from "@/api/http.js";

const login = async (username, password) => {
  try {
    const res = await http.post(
      "/login",
      {
        username,
        password
      },
      { retry: 2, retryDelay: 100 }
    );
    localStorage.setItem("token", res.data.token);
    localStorage.setItem("userInfo", JSON.stringify(res.data.userInfo));
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const getUsers = async () => {
  try {
    const res = await http.get("/getusers", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const addUser = async payload => {
  try {
    const res = await http.post("/adduser", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const editUser = async payload => {
  try {
    const res = await http.post("/edituser", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

const deleteUser = async payload => {
  try {
    const res = await http.post("/deleteuser", payload, {
      retry: 2,
      retryDelay: 100
    });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { login, getUsers, addUser, editUser, deleteUser };

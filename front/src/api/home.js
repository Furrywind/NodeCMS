import http from "@/api/http.js";

const getHome = async () => {
  try {
    const res = await http.get("/gethome", { retry: 3, retryDelay: 100 });
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getHome };

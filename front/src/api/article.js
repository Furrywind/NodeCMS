import http from "@/api/http.js";

const getArticle = async query => {
  try {
    const res = await http.get(
      "/getarticle",
      { params: { slug: query } },
      { retry: 3, retryDelay: 100 }
    );
    return Promise.resolve(res);
  } catch (err) {
    return Promise.resolve(err);
  }
};

export { getArticle };

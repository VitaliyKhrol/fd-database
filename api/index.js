const API_BASE = 'https://randomuser.me/api/'

module.exports.getUsers = async () => {
   const response = await fetch(`${API_BASE}?page=2&results=500&seed=fd-2023`);
   const {results} = await response.json();
   return results;
}
read_post = document.getElementById('link_to_next');
read_post_A = document.getElementById('link_to_next');

read_post_A.addEventListener('click', showAllPost);

function showAllPost(){
    read_post_A.href = "/login";
}
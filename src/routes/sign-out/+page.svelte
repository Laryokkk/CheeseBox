<script>
    import { onMount } from "svelte";
    import { deleteCookie } from "$lib/utils/util-cookie.js";

    onMount(() => {
        deleteCookie("firstname_user");
        deleteCookie("lastname_user");
        deleteCookie("id_user");
        deleteCookie("code_caseificio");
        deleteCookie("permission");

        window.location.href = "/";
    });
</script>

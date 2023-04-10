<script>
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { setCookie } from "$lib/utils/util-cookie.js";

    const handlerSubmit = async (e) => {
        const { target } = e;

        const credentials = {
            email: target.querySelector('input[type="email"]').value,
            psw: target.querySelector('input[type="password"]').value,
        };

        const url = "http://localhost:8888/sign-in.php";

        await fetchPost(url, credentials).then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            console.log(data);

            const { id_user, user_name, user_lastname, user_permission } =
                data;

            setCookie("firstname_user", user_name, 1);
            setCookie("lastname_user", user_lastname, 1);
            setCookie("id_user", id_user, 1);
            if (user_permission.includes("consorzio")) {
                setCookie("permission", "consorzio", 1);
            } else if (user_permission.includes("caseificio")) {
                setCookie("code_caseificio", user_permission.toString().split('_')[1], 1);
                setCookie("permission", "caseificio", 1);
            }

            window.location.href = "/";
        });
    };
</script>

<form class="container" on:submit={handlerSubmit}>
    <Input
        type="email"
        placeholder="Email"
        autocomplete="true"
        required="true"
    />
    <Input
        type="password"
        placeholder="Password"
        autocomplete="true"
        required="true"
    />
    <Button text="Sign In" style="margin-top: 1rem;" />
</form>

<style>
    form.container {
        height: 60vh;

        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        gap: 1rem;
    }
</style>

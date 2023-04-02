<script>
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";
    import { getCookie } from "$lib/utils/util-cookie.js";
    import { onMount } from "svelte";
    

    let user;

    onMount(() => {
        user = getCookie("id_user");
    });

    const handlerSubmit = async (e) => {
        const { target } = e;

        const credentials = {
            firstname: target.querySelector('input[type="text"]').value,
            lastname: target.querySelector('input[type="text"]').value,
            email: target.querySelector('input[type="email"]').value,
            psw: target.querySelector('input[type="password"]').value,
        };

        const url = "http://localhost:8888/sign-up.php";

        await fetchPost(url, credentials).then((fetchResponce) => {
            const { status } = fetchResponce;

            if (status > 200) return;

            window.location.href = "/";
        });
    };
</script>

{#if user}
    <form class="container" on:submit={handlerSubmit}>
        <Input
            type="text"
            placeholder="Nome"
            required="true"
            style="id='firstname'"
        />
        <Input
            type="text"
            placeholder="Cognome"
            required="true"
            style="id='lastname'"
        />
        <Input type="email" placeholder="Email" required="true" />
        <Input type="password" placeholder="Password" required="true" />
        <Button text="Sign In" style="margin-top: 1rem;" />
    </form>
{:else}
    <h4 class="text container">
        Lei non ha il permesso per visitare questa paggina
    </h4>
{/if}

<style>
    .container {
        height: 60vh;

        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        gap: 1rem;
    }
</style>

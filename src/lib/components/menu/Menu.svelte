<script>
    import { getCookie } from "$lib/utils/util-cookie.js";
    import { onMount } from "svelte";

    export let links = [];
    let username;

    onMount(() => {
        username = `${getCookie("firstname_user")} ${getCookie(
            "lastname_user"
        )}`;
    });
</script>

<section class="menu">
    <div class="heading">
        <a href="/">
            <h3 class="text text-extend">CheeseBox</h3>
        </a>
        <h5 class="text text-accent">{username}</h5>
    </div>
    <div class="container">
        {#each links as { title, href, active }}
            <a {href}>
                <h4 class="text text-extend {active ? 'text-accent' : ''}">
                    {title}
                </h4>
            </a>
        {/each}
    </div>
    <div class="footer" />
</section>

<style>
    section.menu {
        height: calc(100vh - 6rem);
        width: calc(20vw - 6rem);

        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: column;
        gap: 8rem;

        padding: 3rem;

        background-color: var(--background-extend);
    }

    div.heading,
    div.container,
    div.footer {
        display: flex;
        align-items: center;
        justify-content: space-around;
        flex-direction: column;
        gap: 1rem;
    }
</style>

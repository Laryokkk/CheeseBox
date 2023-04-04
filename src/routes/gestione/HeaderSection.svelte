<script>
    import { getDate } from "$lib/utils/util-time.js";

    export let content = getDate();
</script>

<section id="header">
    <div class="left">
        <h5 class="text">{@html content}</h5>
    </div>
    <div class="right">
        <a href="/sign-out/">
            <h4 class="text text-accent">Esci</h4>
        </a>
    </div>
</section>

<style>
    section#header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: row;
    }

    div.right {
        display: flex;
        align-items: center;
        flex-direction: row;
        gap: 3rem;
    }
</style>

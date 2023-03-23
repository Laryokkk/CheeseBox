<script>
    export let href;
    export let photoPath;
    export let text;
</script>

<div class="container">
    <a {href}>
        <img src={photoPath} alt="" />
        <h4 class="text">
            {text}
        </h4>
    </a>
</div>

<style>
    div.container {
        width: fit-content;
        height: fit-content;

        position: relative;

        display: flex;
        align-items: center;
        justify-content: center;

        border-radius: 5rem;

        overflow: hidden;
    }

    a {
        display: block;

        width: 100%;
        height: 100%;
    }

    img {
        height: 50vh;
    }

    h4 {
        position: absolute;
        z-index: 10;

        width: 100%;
        height: 20%;

        bottom: 0;

        display: flex;
        align-items: center;
        justify-content: center;

        background-color: var(--background-input);
    }
</style>

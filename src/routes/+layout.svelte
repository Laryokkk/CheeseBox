<script>
    import "../style/style.css";
    import Header from "$lib/components/header/Header.svelte";

    const blobl = {
        v1: {
            left: "100px",
            top: "600px",
        },
        b1: {
            left: "600px",
            top: "300px",
        },
        v2: {
            left: "1300px",
            top: "1200px",
        },
        b2: {
            left: "900px",
            top: "1600px",
        },
    };
</script>

<Header />
<main>
    <slot />
</main>
<div class="blob-v" style="left: {blobl.v1.left}; top: {blobl.v1.top};" />
<div class="blob-b" style="left: {blobl.b1.left}; top: {blobl.b1.top};" />
<div class="blob-v" style="left: {blobl.v2.left}; top: {blobl.v2.top};" />
<div class="blob-b" style="left: {blobl.b2.left}; top: {blobl.b2.top};" />

<style>
    div.blob-v {
        position: absolute;
        width: 339.63px;
        height: 242.45px;

        background: rgba(186, 90, 231, 0.64);
        filter: blur(100px);
        transform: rotate(-6.74deg);
        z-index: -10;

        animation: blobRotation 5000ms linear infinite alternate;
    }

    div.blob-b {
        position: absolute;
        width: 256.44px;
        height: 185.65px;

        background: rgba(249, 228, 196, 0.64);
        filter: blur(100px);
        transform: rotate(-37.25deg);
        z-index: -10;

        animation: blobRotation 5000ms linear infinite alternate;
    }

    @keyframes blobRotation {
        0% {
            transform: scale(1);

        }
        50% {
            transform: scale(1.2);
        }
        100% {
            transform: scale(0.8);
        }
    }
</style>

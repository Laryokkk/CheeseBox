<script>
    import HeaderSection from "../HeaderSection.svelte";
</script>

<section class="container">
    <HeaderSection />
    <div class="container" />
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 2rem;
    }

    div.container {
        display: flex;
        justify-content: space-between;
        flex-direction: row;
        gap: 6rem;
    }
</style>

<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";

    export let listFoto = [
        { src: "/assets/caseificio.png" },
        { src: "/assets/caseificio.png" },
        { src: "/assets/caseificio.png" },
    ];

    $: isButtonDisabled = true;
</script>

<section class="container">
    <HeaderSection />
    <div class="container">
        <div class="container-input">
            <h5 class="text">Nome caseificio:</h5>
            <Input type="text" required="true" value={"current name"} />
        </div>
        <div class="container-input">
            <h5 class="text">Foto:</h5>
            <div class="wrapper-photo">
                {#each listFoto as { src }}
                    <img {src} alt="caseificio" />
                {/each}
            </div>
        </div>
        <Button text="Salva" disabled={isButtonDisabled}/>
    </div>
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: flex-start;
        flex-direction: column;
        gap: 6rem;
    }

    div.container {
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 4rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.6rem;
    }

    div.wrapper-photo {
        display: flex;
        flex-wrap: wrap;
        gap: 2rem;
    }

    img {
        height: 20rem;

        border-radius: 2rem;
    }
</style>

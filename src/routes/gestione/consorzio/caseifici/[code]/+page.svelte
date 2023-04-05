<script>
    import Menu from "$lib/components/menu/Menu.svelte";

    export let data;

    $: code = data.code;
    $: links = data.links;
</script>

<section class="container">
    <Menu {links} goBack={true} />
</section>

<h4 class="text">
    {code}
</h4>

<style>
</style>

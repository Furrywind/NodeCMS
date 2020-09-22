<template>
  <v-tooltip open-delay="250" transition="fade-transition" bottom>
    <template v-for="(_, slot) of $scopedSlots" v-slot:[slot]="scope">
      <slot :name="slot" v-bind="scope" />
    </template>
    {{ toolTipText }}
  </v-tooltip>
</template>

<script>
export default {
  name: "Tooltip",

  props: { toolTipText: String }
};
</script>

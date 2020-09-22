<template>
  <v-data-table
    @page-count="pageCount = $event"
    :page.sync="page"
    :headers="headers"
    :items="items"
    :items-per-page="itemsPerPage"
    :loading="loading"
    :mobile-breakpoint="mobileBreakpoint"
    :search="search"
    :no-data-text="noDataText"
    :loading-text="loadingText"
    :footer-props="{
      showFirstLastPage: true,
      itemsPerPageOptions: itemsPerPageOptions,
      firstIcon: icons.mdiPageFirst,
      lastIcon: icons.mdiPageLast,
      prevIcon: icons.mdiChevronLeft,
      nextIcon: icons.mdiChevronRight
    }"
  >
    <template v-slot:top>
      <v-container class="pa-1">
        <v-row no-gutters>
          <v-col cols="auto">
            <v-menu v-model="showMenu" offset-y>
              <template v-slot:activator="{ on }">
                <v-btn
                  @click="showMenu = !showMenu"
                  :color="showMenu ? 'primary' : ''"
                  v-on="on"
                  class="tableBtn title font-weight-regular px-2"
                  text
                >
                  {{ tableName }}
                  <v-icon
                    :color="showMenu ? 'primary' : 'grey darken-1'"
                    class="ml-1"
                    size="24"
                    right
                  >
                    $dropdown
                  </v-icon>
                </v-btn>
              </template>
              <v-list min-width="215" dense>
                <slot name="tableNameMenu" />
              </v-list>
            </v-menu>
          </v-col>
          <v-col>
            <v-text-field
              v-model="search"
              :label="searchLabel"
              hide-details
              dense
              solo
              flat
            >
              <template v-slot:prepend-inner>
                <v-icon color="grey darken-1">
                  {{ icons.mdiFilterVariant }}
                </v-icon>
              </template>
            </v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-divider />
    </template>

    <template v-for="slot in Object.keys($scopedSlots)" v-slot:[slot]="scope">
      <slot :name="slot" v-bind="scope" />
    </template>
  </v-data-table>
</template>

<script>
import {
  mdiPencilOutline,
  mdiTrashCanOutline,
  mdiChevronLeft,
  mdiChevronRight,
  mdiPageFirst,
  mdiPageLast,
  mdiFilterVariant
} from "@mdi/js";

export default {
  name: "DataTable",

  props: {
    headers: Array,
    items: Array,
    itemsPerPage: Number,
    loading: Boolean,
    mobileBreakpoint: Number,
    itemsPerPageOptions: Array,
    tableName: String
  },

  data: () => ({
    pageCount: 0,
    page: 1,
    search: "",
    noDataText: "Please refresh to try again.",
    loadingText: "Loading...",

    showMenu: false,
    searchLabel: "Filter",

    icons: {
      mdiPencilOutline,
      mdiTrashCanOutline,
      mdiChevronLeft,
      mdiChevronRight,
      mdiPageFirst,
      mdiPageLast,
      mdiFilterVariant
    }
  })
};
</script>

<style lang="scss" scoped>
.tableBtn {
  font-size: 1.125rem !important;
}
</style>

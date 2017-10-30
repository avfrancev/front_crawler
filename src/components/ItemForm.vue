<template lang="pug">
	.grid(v-if="item")
		.col-sm-6
			el-form(:model="item" label-width="25%")
				el-form-item(label="Active")
					el-switch(v-model='item.active' on-text="1" off-text="0" :width="46")

				el-form-item(label="Owner")
					el-select(type="text" v-model="owner")
						el-option(
							v-for="user in users"
							:key="user.id"
							:value="user.id"
							:label="user.displayName || user.username"
							)
				el-form-item(label="Name")
					el-input(type="text" v-model="item.name")
				el-form-item(label="Full Name")
					el-input(type="text" v-model="item.full_name")
				el-form-item(label="Logo")
					el-input(type="text" v-model="item.logo")
				//- el-form-item(label="Capture Selector")
				//-   el-input.input(type="text" v-model="item.captureSelector")
				//- el-form-item(label="Next parse date")
				//-   el-date-picker.input(width="100%" :disabled="!item.active" type="datetime" v-model="item.nextParseDate")

				//-el-form-item
					el-button(type="primary" @click.prevent="submit") SUBMIT
					el-button(type="primary" @click.prevent="logItem") LOG ITEM
		.col-sm-6
			.code
				codemirror(
					v-model="item.schemas"
					:options="editorOptions"
				)
</template>

<script lang="coffee">
export default {
	props:
		item: {}
		users:
			type: Array
			default: []
	computed:
		owner:
			get: -> @item.owner.id
			set: (v) -> @$set(@item, 'owner', @item.owner..., {id: v})
	data: ->
		editorOptions:
			theme: 'dracula'
			mode: 'coffeescript'
			tabSize: 2
			indentWithTabs: true
			lineNumbers: true
			dragDrop: false
}
</script>

<style lang="stylus">
</style>

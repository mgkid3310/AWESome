#%%
script_version_file = open('addons/main/script_version.hpp', 'r')
script_version_lines = script_version_file.readlines()
script_version_lines = [line.strip() for line in script_version_lines]
script_version_file.close()

version_list = []
for line in script_version_lines:
	if line.startswith('#define'):
		version_words = line.split(' ')
		version_list.append(int(version_words[2]))

version_list[-1] += 1
version_list = [str(version) for version in version_list]

script_version_file = open('addons/main/script_version.hpp', 'w')
for idx, line in enumerate(script_version_lines):
	if line.startswith('#define'):
		version_words = line.split(' ')[:2] + [version_list[idx]]
		line = ' '.join(version_words) + '\n'
		script_version_file.write(line)
script_version_file.close()

print('Updated script_version to: ' + '.'.join(version_list))

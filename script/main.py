import os

import polib


class Tools:

    @staticmethod
    def get_file_and_type_name(path_to_file: str):
        """Розрізає на файл на складові - назву і тип файлу"""

        if '.' in path_to_file:
            paths = path_to_file.split('.')
            filename, type_file = '.'.join(paths[:-1]), paths[-1]
            return filename, type_file
        return path_to_file, None

    @staticmethod
    def build_mo_to_po(path_to_file: str):
        """Виконує процес збірки файлів перекладу в зрозумілий формат"""
        filename, type_file = Tools.get_file_and_type_name(path_to_file)

        po = polib.mofile(path_to_file)
        return po.save_as_pofile('%s.%s' % (filename, 'po'))

    @staticmethod
    def build_po_to_mo(path_to_file: str):
        """Виконує процес збірки файлів перекладу в бінарний формат"""
        filename, type_file = Tools.get_file_and_type_name(path_to_file)

        po = polib.pofile(path_to_file)
        return po.save_as_mofile('%s.%s' % (filename, 'mo'))

    @staticmethod
    def get_all_file_in_dir(path_to_dir: str, type_file: str = 'po'):
        """Рекурсивний пошук файлів в каталозі"""
        for root, dirs, files in os.walk(path_to_dir):
            for file in files:
                if '.' in file and type_file == file.split('.')[-1]:
                    yield root, file

                for dir_name in dirs:
                    Tools.get_all_file_in_dir(dir_name)


TITLE = """
     _                                 ____            _   _       _
    | |       __ _   _ __     __ _    | __ )   _   _  (_) | |   __| |   ___   _ __
    | |      / _' | | '_ \   / _' |   |  _ \  | | | | | | | |  / _' |  / _ \ | '__|
    | |___  | (_| | | | | | | (_| |   | |_) | | |_| | | | | | | (_| | |  __/ | |
    |_____|  \__,_| |_| |_|  \__, |   |____/   \__,_| |_| |_|  \__,_|  \___| |_|
                           |___/ 
                           
    """

COUNT_SYMBOLS_LINE = 29


def title_msg():
    return TITLE


def line_msg():
    return COUNT_SYMBOLS_LINE * '-'


def main():
    print(title_msg())

    print(line_msg())
    print("Build language files...")
    print(line_msg())

    source_dir = os.environ.get('DIR', os.getcwd())
    print(f'Found files in directory "{source_dir}"...')

    print("Start build...")
    for path_to_file, file in Tools.get_all_file_in_dir(os.path.join(source_dir), 'po'):
        print(f"Compile {path_to_file}/{file} > {path_to_file}/{'.'.join(file.split('.')[:-1])}.mo")
        Tools.build_po_to_mo(os.path.join(path_to_file, file))

    print("Finish.")


if __name__ == '__main__':
    main()

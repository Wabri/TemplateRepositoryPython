import sys

from helloworld.hello.output import print_hello
import helloworld.world.string as w

print(sys.argv)
if __name__ == '__main__':
    counter = 0
    for arg in sys.argv[1:]:
        arg_split = arg.split('=')
        if arg_split[0] == '--name':
            print_hello(arg_split[1])
            exit()
        else:
            print('Argument {} not valid: {}'.format(counter, arg))
        counter += 1
    print_hello(w.WORLD)


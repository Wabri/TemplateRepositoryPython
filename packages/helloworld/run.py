import sys

from helloworld.hello.output import print_hello
import helloworld.world.string as w

if __name__ == '__main__':
    counter = 0
    world = w.WORLD
    for arg in sys.argv[1:]:
        arg_split = arg.split('=')
        if arg_split[0] == '--name':
            world = arg_split[1]
        else:
            print('Argument {} not valid: {}'.format(counter, arg))
        counter += 1
    print_hello(world)


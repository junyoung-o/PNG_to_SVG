## read
from svgpathtools import svg2paths2, wsvg
import tools as myTools
import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('--inDir', type=str, default='./input', help='Input directory.')
parser.add_argument('--outDir', type=str, default='./output/', help='Output directory.')
parser.add_argument('--refSVG', type=str, default='./Ref-svg.svg', help='Output directory.')
parser.add_argument('--imgSize', type=int, default=800, help='Output svg size.')
parser.add_argument('--strokeWidth', type=float, default=1.8481, help='stroke width.')
args = parser.parse_args()

if not os.path.exists(args.outDir):
    os.makedirs(args.outDir)

dataList = myTools.folder2files(args.inDir, format='.svg')

for svgFileName in dataList:
    paths, attributes, svg_attributes = svg2paths2(svgFileName)

    print(svgFileName)

    # redpath = paths
    # # redpath_attribs = attributes[0]

    # cnt = 0
    # for i in redpath:
    #     cnt += 1

    # for i in redpath:
    #     print(i)

    # print("cnt : ", cnt)
    name = svgFileName.split("/")[-1]
    
    ## write
    wsvg(paths, attributes=attributes, svg_attributes=svg_attributes, filename=f'./{args.outDir}/{name}')